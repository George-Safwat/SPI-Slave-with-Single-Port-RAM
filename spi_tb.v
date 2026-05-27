module spi_tb;
reg mosi,clk,rst_n,SS_n;
wire miso;
reg [9:0] input_data;


reg [3:0] i;

initial begin
    clk=1;
forever #1 clk=~clk;
end

spi_wrapper spi_wrapper1(.MOSI(mosi),.MISO(miso),.SS_n(SS_n),.clk(clk),.rst_n(rst_n));


initial begin
    
    $readmemh("mem.dat",spi_wrapper1.ram1.mem);
    //test reset synchronous low
    rst_n=0;
    SS_n=1;
    @(negedge clk);

    
    //WRITE ADDRESS
    SS_n=0;
    rst_n=1;
    input_data=10'b0010101010; //write address 0x2A
    mosi=input_data[9];//send MSB first
    @(negedge clk); 
    for(i=0;i<9;i=i+1) begin
        mosi=input_data[8-i];//send MSB first
        @(negedge clk);
    end
    @(negedge clk); 
    SS_n=1; 
    @(negedge clk); 

    //WRITE DATA
    input_data=10'b0101111111; //write data 0xFF to address 0x2A
    SS_n=0;
    @(negedge clk);
     mosi=input_data[9];//send MSB first 
    for(i=0;i<9;i=i+1) begin
        mosi=input_data[8-i];//send MSB first
        @(negedge clk);
    end    
    @(negedge clk); 
    SS_n=1; 
    @(negedge clk); 
    
        

    //READ ADDRESS
    input_data=10'b1010101010; //read address 0x2A
    SS_n=0; 
    @(negedge clk);
     mosi=input_data[9];//send MSB first 
    for(i=0;i<9;i=i+1) begin
        mosi=input_data[8-i];//send MSB first
        @(negedge clk);
    end    
    @(negedge clk); 
    SS_n=1; 
    @(negedge clk); 



    //READ DATA
    input_data=10'b1101111111; //read data from address 0x2A
    SS_n=0;
    mosi=input_data[9];//send MSB first 
    @(negedge clk);
    for(i=0;i<9;i=i+1) begin
        mosi=input_data[8-i];//send MSB first
        @(negedge clk);
    end    
    repeat (11)begin 
    @(negedge clk);
    $strobe("miso= %b",miso);
    end 
    SS_n=1; 
    @(negedge clk);   
    

    $stop;
end


endmodule