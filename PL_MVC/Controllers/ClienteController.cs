using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PL_MVC.Controllers
{
    public class ClienteController : Controller
    {
        [HttpGet]// GET: Cliente
        public ActionResult GetAll()
        {
            ML.Cliente cliente = new ML.Cliente();




            cliente.Nombre = (cliente.Nombre == null) ? "" : cliente.Nombre;
            cliente.ApellidoPaterno = (cliente.ApellidoPaterno == null) ? "" : cliente.ApellidoPaterno;
            cliente.ApellidoMaterno = (cliente.ApellidoMaterno == null) ? "" : cliente.ApellidoMaterno;
            cliente.FechaNacimiento = (cliente.FechaNacimiento == null) ? "" : cliente.FechaNacimiento;

            ML.Result result = BL.Cliente.GetAll(cliente);
              

            if (result.Correct)
            {
                cliente.Clientes = result.Objects;
            }
            else
            {
                result.Correct = false;
            }


            return View(cliente);
        }

        [HttpPost]
        public ActionResult GetAll(ML.Cliente cliente)
        {
            //Mandar los parámetros 
            cliente.Nombre = (cliente.Nombre == null) ? "" : cliente.Nombre;
            cliente.ApellidoPaterno = (cliente.ApellidoPaterno == null) ? "" : cliente.ApellidoPaterno;
            cliente.ApellidoMaterno = (cliente.ApellidoMaterno == null) ? "" : cliente.ApellidoMaterno;
            cliente.FechaNacimiento = (cliente.FechaNacimiento == null) ? "" : cliente.FechaNacimiento;

            ML.Result result = BL.Cliente.GetAll(cliente);

            if (result.Correct)
            {
                cliente.Clientes = result.Objects;
            }
            else
            {
                result.Correct = false;
            }
            return View(cliente); //Action result: Tipos de retorno -- ActionResult a una Vista en HTML
        }


        [HttpGet] // Manda la información en blanco 
        public ActionResult Form(int? IdCliente)
        {
            //Instancio mis mètodos            
            ML.Cliente cliente = new ML.Cliente();
            cliente.Domicilio = new ML.Domicilio();
            cliente.Domicilio.Colonia = new ML.Colonia();
            cliente.Domicilio.Colonia.Municipio = new ML.Municipio();
            cliente.Domicilio.Colonia.Municipio.Ciudad = new ML.Ciudad();
            cliente.Domicilio.Colonia.Municipio.Ciudad.Estado = new ML.Estado();

           
            ML.Result resultEstados = BL.Estado.GetAll();//Dropdownlist


            if (resultEstados.Correct)  //Validaciòn de las listas
            {
                if (IdCliente == null) //ADD NOS ENVIARA EL FORMULARIO EN BLANCO
                {                  
                    cliente.Domicilio.Colonia.Municipio.Ciudad.Estado.Estados = resultEstados.Objects; //Guardar la informaciòn
                    return View(cliente);

                }
                else
                {
                    ML.Result result = BL.Cliente.GetByIdEF(IdCliente.Value);
                    if (result.Correct)
                    {

                        //Instancia de mètodos
                        cliente = (ML.Cliente)result.Object;
                        ML.Result resultEstado = BL.Ciudad.GetByIdEstado(cliente.Domicilio.Colonia.Municipio.Ciudad.Estado.IdEstado);
                        ML.Result resultMunicipio = BL.Municipio.GetByIdCiudad(cliente.Domicilio.Colonia.Municipio.Ciudad.IdCiudad);
                        ML.Result resultColonia = BL.Colonia.GetByIdMunicipio(cliente.Domicilio.Colonia.Municipio.IdMunicipio);
                   
                        cliente.Domicilio.Colonia.Colonias = resultColonia.Objects;
                        cliente.Domicilio.Colonia.Municipio.Municipios = resultMunicipio.Objects;
                        cliente.Domicilio.Colonia.Municipio.Ciudad.Ciudades = resultEstado.Objects;
                        cliente.Domicilio.Colonia.Municipio.Ciudad.Estado.Estados = resultEstados.Objects;

                        return View(cliente);
                    }
                    else
                    {
                        return View("Modal");
                    }

                }

            }
            else
            {
            
                return View("Modal");
            }
        }


        [HttpPost] //Envia la petición para el llenado de datos
        public ActionResult Form(ML.Cliente cliente)
        {
            if (cliente.IdCliente == 0)
            {

                ML.Result result = BL.Cliente.AddEF(cliente);

                if (result.Correct)
                {
                    ViewBag.Mensaje = "Registro existoso";
                }
                else
                {
                    ViewBag.Mensaje = "Ocurrio un error" + result.Message;
                }

            }
            else
            {
                ML.Result result = BL.Cliente.UpdateEF(cliente);


                if (result.Correct)
                {


                    ViewBag.Mensaje = "Actualizado el registro exitosamente";
                }
                else
                {
                    ViewBag.Mensaje = "Ocurrio un error" + result.Message;
                }
            }

            return View("Modal");
        }

        [HttpGet] // Manda la información 
        public ActionResult Delete(int IdCliente)
        {
            ML.Cliente cliente = new ML.Cliente();
            //ML.Direccion direccion = new ML.Direccion();

            cliente.IdCliente = IdCliente;

            if (cliente.IdCliente > 0)
            {

                ML.Result result = BL.Cliente.DeleteEF(IdCliente);

                if (result.Correct)
                {
                    ViewBag.Mensaje = "Eliminado el registro exitosamente";
                }
                else
                {
                    ViewBag.Mensaje = "Ocurrio un error" + result.Message;
                }
            }

            return View("Modal");
        }

        //Inicio de Json intermediario con AJAX
        public JsonResult CiudadGetByIdEstado(int IdEstado)
        {
            ML.Result result = BL.Ciudad.GetByIdEstado(IdEstado);

            return Json(result.Objects, JsonRequestBehavior.AllowGet);
        }


        public JsonResult MunicipioGetByIdCiudad(int IdCiudad)
        {
            ML.Result result = BL.Municipio.GetByIdCiudad(IdCiudad);

            return Json(result.Objects, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ColoniaGetByIdMunicipio(int IdMunicipio)
        {
            ML.Result result = BL.Colonia.GetByIdMunicipio(IdMunicipio);

            return Json(result.Objects, JsonRequestBehavior.AllowGet);

        }
        //Fin de Json intermediario con AJAX

    }
}