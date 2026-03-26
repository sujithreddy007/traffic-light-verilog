`timescale 1ns/1ps

module tb_traffic_light;

reg clk;
reg rst;
wire [1:0] H_light;
wire [1:0] S_light;

// Instantiate DUT
traffic_light uut (
    .clk(clk),
    .rst(rst),
    .H_light(H_light),
    .S_light(S_light)
);

// Clock generation (10ns period)
always #5 clk = ~clk;

initial begin
    // Initialize
    clk = 0;
    rst = 1;

    // Dump waveform
    $dumpfile("traffic_light.vcd");
    $dumpvars(0, tb_traffic_light);

    // Reset pulse
    #10 rst = 0;

    // Run simulation
    #200;

    $finish;
end

endmodule