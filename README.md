# VHDL
VHDL-SPI Protocol

**Author: Vinícius Camozzato Vaz**

## Description

Develop a system consisting of two state machines, a BCD converter for
seven segments, and four sliders as shown in Figure below. The two machines are
communicate over an SPI synchronous serial bus, where a machine is master on the
communication and the other is slave.

![Figure 1](https://i.imgur.com/KAc2PC0.png) 

## Goal

The goal is to “type” a binary number into the sliders, the Master machine sends
this number via the SPI bus and the slave machine sends the received number to the
seven segments (via BCD converter). The MISO wire will not be implemented.

## Visuals
**SPI Communication**  
![SPI](https://i.imgur.com/C905gif.png)  
The master sends data over the serial clock rising edge and the slave responds at the falling edge

## Usage
We used [Altera Quartus and Model Sim](http://fpgasoftware.intel.com/13.0/?edition=subscription) to development and tests. 

### Device Info: 

**Name: EP3C16F484C6**  
**Device Family: Cyclone III**  
**Package: FBGA**  
**Pin Count: 484**  
**Speed Grade: 6**  
**Name: EP3C16F484C6**  



## Documentation

You can find the Diagrams and Documentation on this link:
[Documentation](https://github.com/vinicvaz/VHDL/tree/master/Diagrams%20and%20Documentation)

## Contributing
Pull requests are welcome. For major changes, please open an issue or send us an email to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
