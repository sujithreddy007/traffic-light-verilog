module traffic_light(
    input clk,
    input rst,
    output reg [1:0] H_light, // Highway: 00=Red, 01=Yellow, 10=Green
    output reg [1:0] S_light  // Side road
);

// State encoding
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

reg [1:0] state;
reg [3:0] count;

// State transition
always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= S0;
        count <= 0;
    end else begin
        count <= count + 1;

        case(state)
            S0: if (count == 5) begin state <= S1; count <= 0; end
            S1: if (count == 2) begin state <= S2; count <= 0; end
            S2: if (count == 5) begin state <= S3; count <= 0; end
            S3: if (count == 2) begin state <= S0; count <= 0; end
        endcase
    end
end

// Output logic
always @(*) begin
    case(state)
        S0: begin H_light = 2'b10; S_light = 2'b00; end // H Green, S Red
        S1: begin H_light = 2'b01; S_light = 2'b00; end // H Yellow
        S2: begin H_light = 2'b00; S_light = 2'b10; end // S Green
        S3: begin H_light = 2'b00; S_light = 2'b01; end // S Yellow
        default: begin H_light = 2'b00; S_light = 2'b00; end
    endcase
end

endmodule