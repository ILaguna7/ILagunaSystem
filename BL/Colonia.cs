using System;
using System.Collections.Generic;
using System.Linq;

namespace BL
{
    public class Colonia
    {
        public static ML.Result GetByIdMunicipio(int IdMunicipio)
        {

            ML.Result result = new ML.Result();

            try
            {
                using (DL.ILagunaNetaSystemEntities context = new DL.ILagunaNetaSystemEntities())
                {
                    var query = context.ColoniaGetByIdMunicipio(IdMunicipio).ToList();
                    result.Objects = new List<object>();

                    if (query != null)
                    {

                        foreach (var obj in query)
                        {
                            ML.Colonia colonia = new ML.Colonia();

                            colonia.IdColonia = obj.IdColonia;
                            colonia.Nombre = obj.Nombre;
                            colonia.CodigoPostal = obj.CodigoPostal;
                            colonia.Municipio = new ML.Municipio();
                            colonia.Municipio.IdMunicipio = obj.IdMunicipio.Value;

                            result.Objects.Add(colonia);
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
