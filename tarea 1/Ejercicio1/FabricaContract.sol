//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract FabricaContract {
    uint idDigits = 16;
    struct Producto {
        string nombre;
        uint identificacion;
    }
    Producto[] productos;
    

    function _crearProducto (string memory _nombre, uint _id) private {
        productos.push(Producto(_nombre,_id));

        emit NuevoProducto(productos.length-1,_nombre,_id);
    }

    function _generarIdAleatorio (string memory _str) private view returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        uint idModulus = 10^idDigits;
        return rand % idModulus;
    }

    function crearProductoAleatorio (string memory _nombre) public {
        uint randId = _generarIdAleatorio(_nombre);
        _crearProducto(_nombre, randId);
    }

    event NuevoProducto(uint ArrayProductoId, string nombre, uint id);

    mapping (uint => address) public productoAPropietario;

    mapping (address => uint) public propietarioProductos;

    function Propiedad (uint productoId) public {
        productoAPropietario[productoId] = msg.sender;
        propietarioProductos[msg.sender] = productoId;
    }

    function getProductosPorPropietario (address _propietario)  external view  returns(uint[] memory) {
        uint contador = 0;
        uint n = propietarioProductos [_propietario];
        uint [] memory resultado = new uint[](n);

        for (uint i=0; i <= resultado.length;i++){
            if(productoAPropietario[i]==_propietario){
                resultado[contador] = propietarioProductos[productoAPropietario[i]];
                contador++;
            }
           

        }
        return resultado;
        
    }
}