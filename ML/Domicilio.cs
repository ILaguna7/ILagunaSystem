using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML
{
    public class Domicilio
    {
        public int IdDomicilio { get; set; }
        public string Calle { get; set; }
        public string NumeroExterior  { get; set; }
        public string NumeroInterior  { get; set; }
        public List<object> Domicilios { get; set; }
        public ML.Cliente Cliente { get; set; }
        public ML.Colonia Colonia { get; set; }

    }
}
