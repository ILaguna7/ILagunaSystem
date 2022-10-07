using System;
using System.Collections.Generic;
using System.Linq;

namespace BL
{
    public class Ciudad
    {
        public static ML.Result GetByIdEstado(int IdEstado)
        {

            ML.Result result = new ML.Result();

            try
            {
                using (DL.ILagunaNetaSystemEntities context = new DL.ILagunaNetaSystemEntities())
                {
                    var query = context.CiudadGetByIdEstado(IdEstado).ToList();
                    result.Objects = new List<object>();

                    if (query != null)
                    {
                        foreach (var obj in query)
                        {

                            ML.Ciudad ciudad = new ML.Ciudad();
                            ciudad.Estado = new ML.Estado();

                            ciudad.IdCiudad = obj.IdCiudad;
                            ciudad.Nombre = obj.Nombre;
                            ciudad.Estado.IdEstado = obj.IdEstado.Value;

                            result.Objects.Add(ciudad);

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

    }
}
