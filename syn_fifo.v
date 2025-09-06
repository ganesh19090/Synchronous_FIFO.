module syn_fifo(clk,rst,wr_en,rd_en,wdata,rdata,full,overflow,empty,underflow);
parameter WIDTH=8;
parameter FIFO_SIZE=16;
parameter PTR_WIDTH=$clog2(FIFO_SIZE);

input clk,rst,wr_en,rd_en;
input [WIDTH-1:0]wdata;
output reg[WIDTH-1:0]rdata;
output reg full,overflow,empty,underflow;

reg[PTR_WIDTH-1:0]wr_ptr,rd_ptr;  //internal signals
reg wr_toggle_f,rd_toggle_f;
reg[WIDTH-1:0]fifo[FIFO_SIZE-1:0];  //memory declaration
integer i;

always@(posedge clk) begin
if(rst==1) begin   //all reg signal to 0
rdata=0;
full=0;
empty=1;
overflow=0;
underflow=0;
wr_ptr=0;
rd_ptr=0;
wr_toggle_f=0;
rd_toggle_f=0;
for(i=0;i<FIFO_SIZE;i=i+1) fifo[i]=0;
end

else begin
if(wr_en==1) begin
if(full==1) overflow=1;    //FIFO__SIZE is full
else begin
fifo[wr_ptr]=wdata;
if(wr_ptr==FIFO_SIZE-1) begin   //check for FIFO_SIZE and assign token for next value
wr_ptr=0;
wr_toggle_f=~wr_toggle_f;
end
else 
wr_ptr=wr_ptr+1;   //incement the pointer
end
end

if(rd_en==1) begin
if(empty==1) underflow=1;    //FIFO__SIZE is full
else begin
rdata=fifo[rd_ptr];
if(rd_ptr==FIFO_SIZE-1) begin   //check for FIFO_SIZE and assign token for next value
rd_ptr=0;
rd_toggle_f=~rd_toggle_f;
end
else
rd_ptr=rd_ptr+1;   //incement the pointer
end
end
end
end

always @(*) begin
if(wr_ptr==rd_ptr && wr_toggle_f!=rd_toggle_f) full=1;  //wr_ptr=0  rd_ptr=0 && wr_toogle_f =1  rd_toggle_f=0=>overflow
else full=0;
if(wr_ptr==rd_ptr && wr_toggle_f==rd_toggle_f) empty=1;  ///wr_ptr=0  rd_ptr=0 && wr_toogle_f =0 rd_toggle_f=0=underflow
else empty=0;
end
endmodule
