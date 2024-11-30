`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:04:35
// Design Name: 
// Module Name: EmotionDetection
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


module EmotionDetection (
    input logic [511:0] image,             
    output logic [1:0] mood                
);

    logic signed [7:0] feature1, feature2, feature3, feature4;

    logic signed [7:0] hidden1_output [15:0];
    logic signed [7:0] hidden2_output [7:0];
    logic signed [7:0] final_output;

    logic signed [7:0] layer1_weights [15:0][3:0];
    logic signed [7:0] layer1_biases [15:0];
    logic signed [7:0] layer2_weights [7:0][15:0];
    logic signed [7:0] layer2_biases [7:0];
    logic signed [7:0] output_weights [0:7];
    logic signed [7:0] output_bias [0:1];

    initial begin
        $readmemh("layer1_weights.mem", layer1_weights);
        $readmemh("layer1_biases.mem", layer1_biases);
        $readmemh("layer2_weights.mem", layer2_weights);
        $readmemh("layer2_biases.mem", layer2_biases);
        $readmemh("layer3_weights.mem", output_weights);
        $readmemh("layer3_biases.mem", output_bias);
    end

    
    ImagePreprocessing image_preprocess (
        .image(image),
        .feature1(feature1),
        .feature2(feature2),
        .feature3(feature3),
        .feature4(feature4)
    );

    
    DenseLayer_WithBias #(.INPUT_SIZE(4), .OUTPUT_SIZE(16)) hidden_layer1 (
        .input_data({feature1, feature2, feature3, feature4}),
        .weights(layer1_weights),
        .biases(layer1_biases),
        .output_data(hidden1_output)
    );

    
    DenseLayer_WithBias #(.INPUT_SIZE(16), .OUTPUT_SIZE(8)) hidden_layer2 (
        .input_data(hidden1_output),
        .weights(layer2_weights),
        .biases(layer2_biases),
        .output_data(hidden2_output)
    );

  
    DenseLayer_WithBias #(.INPUT_SIZE(8), .OUTPUT_SIZE(1)) output_layer (
        .input_data(hidden2_output),
        .weights(output_weights),
        .biases({output_bias}),
        .output_data(final_output)
    );

    always_comb begin
        if (final_output > 0)
            mood = 2'b01; 
        else
            mood = 2'b10; 
    end

endmodule

