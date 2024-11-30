`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:10:11
// Design Name: 
// Module Name: ImagePreprocessing
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


module ImagePreprocessing (
    input logic [511:0] image,            
    output logic signed [7:0] feature1,
    output logic signed [7:0] feature2,
    output logic signed [7:0] feature3,
    output logic signed [7:0] feature4
);

    always_comb begin
        feature1 = image[7:0] + image[15:8] + image[23:16];        
        feature2 = image[63:56] + image[71:64] + image[79:72];      
        feature3 = image[7:0] - image[63:56];                       
        feature4 = image[15:8] - image[71:64];                      
    end

endmodule
