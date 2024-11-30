`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:29:02
// Design Name: 
// Module Name: ArtGenerator
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


module ArtGenerator (
    input logic signed [7:0] noise [1599:0],      
    input logic [1:0] mood,                        
    output logic signed [7:0] generated_image [8][8]  
);

    logic signed [7:0] layer1_weights[15:0][1600:0];
    logic signed [7:0] layer2_weights[15:0][15:0];
    logic signed [7:0] layer3_weights[63:0][2047:0];
    logic signed [7:0] layer4_weights[7:0][63:0];

    logic signed [7:0] layer1_output[15:0];
    logic signed [7:0] layer2_output[15:0];
    logic signed [7:0] layer3_output[63:0];
    logic signed [7:0] layer4_output[7:0];

    initial begin
        if (mood == 2'b01) begin
            $readmemh("layer1weightshappy.mem", layer1_weights);
            $readmemh("layer2weightshappy.mem", layer2_weights);
            $readmemh("layer3weighthappy.mem", layer3_weights);
            $readmemh("layer4weightshappy.mem", layer4_weights);
        end else if (mood == 2'b10) begin
            $readmemh("layer1weightsad.mem", layer1_weights);
            $readmemh("layer2weightsad.mem", layer2_weights);
            $readmemh("layer3weightsad.mem", layer3_weights);
            $readmemh("layer4weightsad.mem", layer4_weights);
        end
    end

    DenseLayer_WeightsOnly #(.INPUT_SIZE(1600), .OUTPUT_SIZE(16)) layer1 (.input_data(noise), .weights(layer1_weights), .output_data(layer1_output));
    DenseLayer_WeightsOnly #(.INPUT_SIZE(16), .OUTPUT_SIZE(16)) layer2 (.input_data(layer1_output), .weights(layer2_weights), .output_data(layer2_output));
    DenseLayer_WeightsOnly #(.INPUT_SIZE(16), .OUTPUT_SIZE(64)) layer3 (.input_data(layer2_output), .weights(layer3_weights), .output_data(layer3_output));
    DenseLayer_WeightsOnly #(.INPUT_SIZE(64), .OUTPUT_SIZE(8)) layer4 (.input_data(layer3_output), .weights(layer4_weights), .output_data(layer4_output));

    always_comb begin
        for (int i = 0; i < 8; i++) begin
            for (int j = 0; j < 8; j++) begin
                generated_image[i][j] = layer4_output[i * 8 + j];
            end
        end
    end

endmodule

