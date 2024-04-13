module runningAdd(
input	clock,
input   reset,
input   [15:0] i_data,
input   i_data_valid,
output  reg [255:0] o_data,
output reg o_data_valid
);

always @(posedge clock)
begin
    if(reset)
       o_data <= 0;
    else if(i_data_valid)
       o_data <= o_data + i_data;
end

always @(posedge clock)
    o_data_valid <= i_data_valid;


endmodule