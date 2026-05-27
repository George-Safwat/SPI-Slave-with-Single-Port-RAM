module spi(MOSI, MISO, clk, SS_n, rst_n,
rx_valid,tx_valid,rx_data,tx_data);

parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_ADD=3'b011;
parameter READ_DATA=3'b100;


input MOSI, clk, rst_n;
input SS_n;
output reg MISO=0, rx_valid;
output reg [9:0] rx_data;
input tx_valid;
input [7:0] tx_data;
reg [9:0] counter_bits=10'b0;
reg [2:0] data_out_counter=3'b111; //counter starts from MSB of of tx_data
reg [3:0] data_in_counter=4'b1010; //counter starts from MSB of of rx_data
reg [2:0] cs,ns;


always @(posedge clk ) begin 
    if(!rst_n && SS_n)begin
    cs<=IDLE;
    rx_data<=0;
    rx_valid<=0;
    end
    else
    cs<=ns;
end


always@(posedge clk) begin

    if(rst_n && !SS_n)begin

        if(data_in_counter!=0)begin
              //store received data in rx_data register when rx_valid is high
            counter_bits<={counter_bits[8:0], MOSI}; //shift left register to store incoming bits
            data_in_counter<=data_in_counter-1;
        end
        if(data_in_counter==0) begin 
            data_in_counter<=10;//reset counter for next transmission = 0 --> 10
            rx_data<=counter_bits;
            rx_valid<=1;
        end
         if(cs==READ_DATA) begin
                if(tx_valid) begin
                    MISO<=tx_data[data_out_counter];//data_out_counter starts from index 7 (MSB) of tx_data
                        if(data_out_counter==0) data_out_counter<=3'b111;
                        else data_out_counter<=data_out_counter-1;
                end
            
                else MISO<=0;
    
                 end
    
    
        end
        else counter_bits<=0;
end
   

always@(*) begin
    case(cs)
    IDLE: begin
        if(SS_n) 
        ns=IDLE;
        else
        ns=CHK_CMD;
    end 
    CHK_CMD: begin
        if(!SS_n) begin
            if (data_in_counter==9 && counter_bits[0]==0 ) // WRITE 
                ns=WRITE;    
            else if(data_in_counter==8 && counter_bits[1:0]==2'b10) // READ ADDRESS
                ns=READ_ADD;
            else if(data_in_counter==8 && counter_bits[1:0]==2'b11) // READ DATA
                ns=READ_DATA;
            else begin 
            ns=CHK_CMD;
            rx_valid=0;
            end 
        end
        else ns=IDLE; //invalid command, go back to IDLE
  
        end

    WRITE: begin
        if(!SS_n && data_in_counter!=0) ns=WRITE;
        else ns=IDLE;
    end
    READ_ADD: begin
        if(!SS_n && data_in_counter!=0 ) ns=READ_ADD;
       else ns=IDLE;
    end

    READ_DATA: begin
    if(!SS_n) ns=READ_DATA;
    else ns=IDLE;
    end

    default: ns=IDLE;
  endcase

end
  
endmodule 