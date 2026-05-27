module ram(din,rx_valid,tx_valid,clk,rst_n,dout);
input [9:0] din;
input clk,rst_n,rx_valid;
output reg tx_valid;
output reg [7:0] dout;
parameter MEM_DEPTH=256, ADDR_SIZE=8;
reg [ADDR_SIZE-1:0] hold_wraddr;
reg [ADDR_SIZE-1:0] hold_rdaddr;

reg [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];

always @(posedge clk) begin
    if (!rst_n) begin
        dout<=0;
        hold_wraddr<=0;
        hold_rdaddr<=0;
        tx_valid<=0;
    end 
    else begin 
        case (din[9:8])
        2'b00: if (rx_valid) //write address
            hold_wraddr<= din[7:0];  
        2'b01:if (rx_valid) //write data
              mem[hold_wraddr]<=din[7:0];//write data
        
        2'b10:if (rx_valid) //read address
             hold_rdaddr<=din[7:0];//read address
        
        2'b11: //read data
            begin 
                dout<=mem[hold_rdaddr];
                tx_valid<=1;
            end
        default: tx_valid<=0;    
        endcase
        end
    end


endmodule