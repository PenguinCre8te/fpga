module blink (
    input clk,
    output reg [5:0] led
);
    reg [25:0] counter = 26'd0;

    always @(posedge clk) begin
        counter <= counter + 1'b1;
        led[0] <= ~counter[25] & ~counter[24] & ~counter[23];
        led[1] <= ~counter[25] & ~counter[24] & counter[23];
        led[2] <= ~counter[25] & counter[24] & ~counter[23];
        led[3] <= ~counter[25] & counter[24] & counter[23];
        led[4] <= counter[25] & ~counter[24] & ~counter[23];
        led[5] <= counter[25] & ~counter[24] & counter[23];
    end
endmodule