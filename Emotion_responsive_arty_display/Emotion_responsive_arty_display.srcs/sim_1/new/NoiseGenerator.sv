`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:23:59
// Design Name: 
// Module Name: NoiseGenerator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module NoiseGenerator (
    input logic clk,                             
    input logic rst,                             
    output logic signed [7:0] noise [9:0]     
);

    logic [15:0] lfsr;
    logic signed [7:0] random_value;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr <= 16'hACE1;  
        end else begin
            lfsr <= {lfsr[14:0], lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10]};
        end
    end

    always_comb begin
        random_value = lfsr[7:0] ^ 8'h80;  
    end

    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 10; i++) begin
                noise[i] <= 8'sd0;  
            end
        end else begin
            for (int i = 0; i < 10; i++) begin
                noise[i] <= random_value;  
            end
        end
    end

endmodule

