// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MagicNum {
    address public solver;

    constructor() public {}

    function setSolver(address _solver) public {
        solver = _solver;
    }

    function getSolverSize() public view returns (uint256) {
        uint256 size;
        address solverCopy = solver;
        assembly {
            size := extcodesize(solverCopy)
        }
        return size;
    }

    /*
    ____________/\\\_______/\\\\\\\\\_____        
     __________/\\\\\_____/\\\///////\\\___       
      ________/\\\/\\\____\///______\//\\\__      
       ______/\\\/\/\\\______________/\\\/___     
        ____/\\\/__\/\\\___________/\\\//_____    
         __/\\\\\\\\\\\\\\\\_____/\\\//________   
          _\///////////\\\//____/\\\/___________  
           ___________\/\\\_____/\\\\\\\\\\\\\\\_ 
            ___________\///_____\///////////////__
  */
}
