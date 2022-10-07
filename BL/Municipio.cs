using System;
using System.Collections.Generic;
using System.Linq;

namespace BL
{
    public class Municipio
    {
        public static ML.Result GetByIdCiudad(int IdCiudad)
        {

            ML.Result result = new ML.Result();

            try
            {
                using (DL.ILagunaNetaSystemEntities context = new DL.ILagunaNetaSystemEntities())
                {
                    var query = context.MunicipioGetByIdCiudad(IdCiudad).ToList();
                    result.Objects = new List<object>();

                    if (query != null)
                    {
                        foreach (var obj in query)
                        {
                            ML.Municipio municipio = new ML.Municipio();

                            municipio.IdMunicipio = obj.IdMunicipio;
                            municipio.Nombre = obj.Nombre;
                            municipio.Ciudad = new ML.Ciudad();
                            municipio.Ciudad.IdCiudad = obj.IdCiudad.Value;


                            result.Objects.Add(municipio);
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
