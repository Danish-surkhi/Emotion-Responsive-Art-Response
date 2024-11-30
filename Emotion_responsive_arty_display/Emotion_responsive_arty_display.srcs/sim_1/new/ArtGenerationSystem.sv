`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:17:02
// Design Name: 
// Module Name: ArtGenerationSystem
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


module ArtGenerationSystem (
    input logic [1:0] mood,                    
    output logic [7:0] ascii_art [8][8]        
);

    logic signed [7:0] noise [10];

    logic signed [7:0] generated_image [8][8];

    NoiseGenerator ng (
        .noise(noise)
    );

    ArtGenerator ag (
        .noise(noise),
        .mood(mood),
        .generated_image(generated_image)
    );

    ASCIIConverter ac (
        .generated_image(generated_image),
        .ascii_art(ascii_art)
    );

endmodule
