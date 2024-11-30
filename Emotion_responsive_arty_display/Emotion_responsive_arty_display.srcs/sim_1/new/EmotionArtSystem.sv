`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:02:16
// Design Name: 
// Module Name: EmotionArtSystem
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


module EmotionArtSystem (
    input logic [511:0] image,          
    output logic [7:0] ascii_art [8][8] 
);

    logic [1:0] mood; 

    EmotionDetection emotion_classifier (
        .image(image),      
        .mood(mood)         
    );

    ArtGenerationSystem art_gen_system (
        .mood(mood),        
        .ascii_art(ascii_art) 
    );

endmodule
