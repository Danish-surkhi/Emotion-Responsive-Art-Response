`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:14:21
// Design Name: 
// Module Name: DenseLayer_WithBias
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


module DenseLayer_WithBias #(
    parameter int INPUT_SIZE = 4,
    parameter int OUTPUT_SIZE = 4,
    parameter int ACTIVATION = 1    
) (
    input logic signed [7:0] input_data [INPUT_SIZE],
    input logic signed [7:0] weights [OUTPUT_SIZE][INPUT_SIZE],
    input logic signed [7:0] biases [OUTPUT_SIZE],
    output logic signed [7:0] output_data [OUTPUT_SIZE]
);

    always_comb begin
        logic signed [15:0] sum; 
        logic signed [7:0] activated_output;

        for (int i = 0; i < OUTPUT_SIZE; i++) begin
            sum = biases[i];  
            for (int j = 0; j < INPUT_SIZE; j++) begin
                sum += input_data[j] * weights[i][j];
            end

            activated_output = sum[15:8];

            case (ACTIVATION)
                1: activated_output = (activated_output > 0) ? activated_output : 0; // ReLU
                2: activated_output = (activated_output > 63) ? 127 : 
                                     (activated_output < -63) ? -127 : 
                                     (activated_output * 2); 
                default: activated_output = activated_output; 
            endcase

            output_data[i] = activated_output;
        end
    end
endmodule