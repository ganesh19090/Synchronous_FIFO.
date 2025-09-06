`include "syn_fifo.v"
module tb;

parameter WIDTH=8;
parameter FIFO_SIZE=16; //DEPTH
parameter PTR_WIDTH=$clog2(FIFO_SIZE);

reg clk,rst,wr_en,rd_en;
reg [WIDTH-1:0]wdata;
wire[WIDTH-1:0]rdata;
wire full,overflow,empty,underflow;

syn_fifo dut(clk,rst,wr_en,rd_en,wdata,rdata,full,overflow,empty,underflow);  //instantiation

integer i,j,k,l,rd_delay,wr_delay;
reg [15*8-1:0]test_name;
always #5 clk=~clk;
initial begin
clk=0;
rst=1;
wdata=0;
rd_en=0;
wr_en=0;
repeat(2) @(posedge clk);
rst=0;
//writes(FIFO_SIZE);  //call write task
//reads(FIFO_SIZE);    //call read task

$value$plusargs("test_name=%0s",test_name);
case(test_name)
"FULL":begin
writes(FIFO_SIZE);
end

"OVERFLOW":begin
writes(FIFO_SIZE+1);
end

"EMPTY":begin
writes(FIFO_SIZE);
reads(FIFO_SIZE);
end

"UNDERFLOW":begin
writes(FIFO_SIZE);
reads(FIFO_SIZE+1);
end

"CONCURRENT":begin
fork
begin
for(k=0;k<20;k=k+1) begin  //20 writes 
writes(1);
wr_delay=$urandom_range(5,10);
#(wr_delay);
end
end
begin
for(l=0;l<20;l=l+1) begin  //20 reads parrallely(concurrently)
reads(1);
rd_delay=$urandom_range(5,10);
#(rd_delay);
end
end
join
end
endcase
#100;
$finish;
end

task writes(input integer num_writes); begin //task writes
for(i=0;i<num_writes;i=i+1) begin
@(posedge clk);
wr_en=1;
wdata=$random;
end
@(posedge clk);
wr_en=0;
wdata=0;
end
endtask

task reads(input integer num_reads); begin //task reads
for(j=0;j<num_reads;j=j+1) begin
@(posedge clk);
rd_en=1;
end
@(posedge clk);
rd_en=0;
end
endtask

endmodule



