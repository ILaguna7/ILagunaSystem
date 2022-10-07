using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class Cliente
    {
        public static ML.Result AddEF(ML.Cliente cliente)
        {
            ML.Result result = new ML.Result();

            try
            {
                using (DL.ILagunaNetaSystemEntities context = new DL.ILagunaNetaSystemEntities())
                {

                    var query = context.ClienteAdd(cliente.Nombre, cliente.ApellidoPaterno, cliente.ApellidoMaterno, cliente.FechaNacimiento, cliente.Telefono, cliente.Celular, cliente.Email, cliente.Domicilio.Calle, cliente.Domicilio.NumeroExterior, cliente.Domicilio.NumeroInterior, cliente.Domicilio.Colonia.IdColonia);

                    if (query > 0)
                    {
                        result.Correct = true;
                    }
                    else
                    {
                        result.Correct = false;
                    }
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.Message = ex.Message;
                result.Ex = ex;

            }

            return result;
        }

        public static ML.Result UpdateEF(ML.Cliente cliente)
        {
            ML.Result result = new ML.Result();

            try
            {
                using (DL.ILagunaNetaSystemEntities context = new DL.ILagunaNetaSystemEntities())
                {

                    var query = context.ClienteUpdate(cliente.IdCliente, cliente.Nombre, cliente.ApellidoPaterno, cliente.ApellidoMaterno, cliente.FechaNacimiento, cliente.Telefono, cliente.Celular, cliente.Email, cliente.Domicilio.IdDomicilio,cliente.Domicilio.Calle, cliente.Domicilio.NumeroExterior,cliente.Domicilio.NumeroInterior, cliente.Domicilio.Colonia.IdColonia);

                    if (query > 0)
                    {
                        result.Correct = true;
                    }
                    else
                    {
                        result.Correct = false;
                    }
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.Message = ex.Message;
                result.Ex = ex;

            }

            return result;
        }



        public static ML.Result GetAll(ML.Cliente clienteBusquedaAbierta)

        {
            ML.Result result = new ML.Result();

            try
            {
                using (DL.ILagunaNetaSystemEntities context = new DL.ILagunaNetaSystemEntities())
                {
                    var clientes = context.ClienteGetAllBusqueda(clienteBusquedaAbierta.Nombre, clienteBusquedaAbierta.ApellidoPaterno, clienteBusquedaAbierta.ApellidoMaterno, clienteBusquedaAbierta.FechaNacimiento).ToList(); //Declaro mis varibales 

                    result.Objects = new List<object>();

                    if (clientes != null)
                    {
                        foreach (var obj in clientes)
                        {
                            ML.Cliente cliente = new ML.Cliente();

                            cliente.IdCliente = obj.IdCliente;
                            cliente.Nombre = obj.Nombre;
                            cliente.ApellidoPaterno = obj.ApellidoPaterno;
                            cliente.ApellidoMaterno = obj.ApellidoMaterno;
                            cliente.FechaNacimiento = obj.FechaNacimiento;
                            cliente.Telefono = obj.Telefono;
                            cliente.Celular = obj.Celular;
                            cliente.Email = obj.Email;
                            cliente.Domicilio = new ML.Domicilio();
                            cliente.Domicilio.IdDomicilio = obj.IdDomicilio;
                            cliente.Domicilio.Calle = obj.Calle;
                            cliente.Domicilio.NumeroExterior = obj.NumeroExterior;
                            cliente.Domicilio.NumeroInterior = obj.NumeroInterior;
                            cliente.Domicilio.Colonia = new ML.Colonia();
                            cliente.Domicilio.Colonia.IdColonia = obj.IdColonia;
                            cliente.Domicilio.Colonia.Nombre = obj.NombreColonia;
                            cliente.Domicilio.Colonia.Municipio = new ML.Municipio();
                            cliente.Domicilio.Colonia.Municipio.IdMunicipio = obj.IdMunicipio;
                            cliente.Domicilio.Colonia.Municipio.Nombre = obj.NombreMunicipio;
                            cliente.Domicilio.Colonia.Municipio.Ciudad = new ML.Ciudad();
                            cliente.Domicilio.Colonia.Municipio.Ciudad.IdCiudad = obj.IdCiudad;
                            cliente.Domicilio.Colonia.Municipio.Ciudad.Nombre = obj.NombreCiudad;
                            cliente.Domicilio.Colonia.Municipio.Ciudad.Estado = new ML.Estado();
                            cliente.Domicilio.Colonia.Municipio.Ciudad.Estado.IdEstado = obj.IdEstado;
                            cliente.Domicilio.Colonia.Municipio.Ciudad.Estado.Nombre = obj.NombreEstado;

                            result.Objects.Add(cliente);
                        }

                        result.Correct = true;
                    }
                    else
                    {
                        result.Correct = false;
                    }
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.Message = ex.Message;
                result.Ex = ex;

            }

            return result;
        }

        public static ML.Result GetByIdEF(int IdCliente)
        {
            ML.Result result = new ML.Result();

            try
            {
                using (DL.ILagunaNetaSystemEntities context = new DL.ILagunaNetaSystemEntities())
                {

                    var obj = context.ClienteGetById(IdCliente).FirstOrDefault();

                    if (obj != null)
                    {
                        ML.Cliente cliente = new ML.Cliente();

                        cliente.IdCliente = obj.IdCliente;
                        cliente.Nombre = obj.Nombre;
                        cliente.ApellidoPaterno = obj.ApellidoPaterno;
                        cliente.ApellidoMaterno = obj.ApellidoMaterno;
                        cliente.FechaNacimiento = obj.FechaNacimiento;
                        cliente.Telefono = obj.Telefono;
                        cliente.Celular = obj.Celular;
                        cliente.Email = obj.Email;                  
                        cliente.Domicilio = new ML.Domicilio();
                        cliente.Domicilio.IdDomicilio = obj.IdDomicilio;
                        cliente.Domicilio.Calle = obj.Calle;
                        cliente.Domicilio.NumeroExterior = obj.NumeroExterior;
                        cliente.Domicilio.NumeroInterior = obj.NumeroInterior;
                        cliente.Domicilio.Colonia = new ML.Colonia();
                        cliente.Domicilio.Colonia.IdColonia = obj.IdColonia;
                        cliente.Domicilio.Colonia.Nombre = obj.NombreColonia;
                        cliente.Domicilio.Colonia.CodigoPostal = obj.CodigoPostal;
                        cliente.Domicilio.Colonia.Municipio = new ML.Municipio();
                        cliente.Domicilio.Colonia.Municipio.IdMunicipio = obj.IdMunicipio;
                        cliente.Domicilio.Colonia.Municipio.Nombre = obj.NombreMunicipio;
                        cliente.Domicilio.Colonia.Municipio.Ciudad = new ML.Ciudad();
                        cliente.Domicilio.Colonia.Municipio.Ciudad.IdCiudad = obj.IdCiudad;
                        cliente.Domicilio.Colonia.Municipio.Ciudad.Nombre = obj.NombreCiudad;
                        cliente.Domicilio.Colonia.Municipio.Ciudad.Estado = new ML.Estado();
                        cliente.Domicilio.Colonia.Municipio.Ciudad.Estado.IdEstado = obj.IdEstado;
                        cliente.Domicilio.Colonia.Municipio.Ciudad.Estado.Nombre = obj.NombreEstado;

                        result.Object = cliente;

                        result.Correct = true;

                    }
                    else
                    {
                        result.Correct = false;
                    }
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.Message = ex.Message;
                result.Ex = ex;
            }

            return result;
        }

        public static ML.Result DeleteEF(int IdCliente)
        {
            ML.Result result = new ML.Result();

            try
            {
                using (DL.ILagunaNetaSystemEntities context = new DL.ILagunaNetaSystemEntities())
                {

                    var query = context.ClienteDelete(IdCliente);

                    if (query > 0)
                    {
                        ML.Cliente cliente = new ML.Cliente();

                        cliente.IdCliente = IdCliente;


                        result.Correct = true;
                    }
                    else
                    {
                        result.Correct = false;
                    }
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.Message = ex.Message;
                result.Ex = ex;
            }
            return result;
        }
    }
}
