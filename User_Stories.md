# User Stories para VoxxMap

VoxxMap es una empresa encargada de ofrecer soluciones para el bien público a través del análisis de datos y la participación ciudadana. En esta ocasión VoxxMap busca, por medio de encuestas, combatir la crisis mundial que se esta viviendo a causa del COVID-19.


**Epic Story: Como VoxxMap quiero levantar datos de los hospitales para poder analizarlos**

1. _**Formular la Encuesta**_ Como VoxxMap debo poder tener los datos necesarios de cada hospital sin importar lo remoto que sea el lugar en el que se ubique. Los datos se obtendrán a partir de un Google Forms con preguntas específicas de los casos covid y de los datos geográficos del hospital.
2. _**Organización de Datos**_ Como VoxxMap necesito poder integrar los resultados obtenidos en una base de datos para poder organizarla y hacer buen uso de la información recopilada.

**Epic Story: Como VoxxMap quiero tener una base de datos confiable y flexible, para poder guardar y actualizar información.**

1. _**Creación de la Base de Datos**_ Como Voxxmap requiero de una base de datos confiable para poder levantar reportes con el menor ruido posible. Debe cumplir con las reglas de normalización y seguir las mejores prácticas.
2. _**Establecer Conexión a la Base de Datos**_ Como VoxxMap necesito que las respuestas de la encuesta se reflejen en la base de datos a través de una conexión automatizada con AWS para tener la información siempre al día.

**Epic Story: Como VoxxMap requiero de un ánalisis de los datos de los hospitales**

1. _**Ánalisis de Datos con Funciones de PostgreSQL**_ Como VoxxMap deseo obtener conclusiones a partir de la información levantada que sea valiosa para llevar a cabo el análisis necesario.
2. _**Monitoreo de Hospitales con Información Incompleta**_ Como VoxxMap quiero saber qué hospitales deben ser contactados otra vez para llenar vacíos de información y asegurar un mayor alcance del proyecto.
3. _**Presentación de Tableros Gráficos**_ Como VoxxMap busco tener representaciones gráficas de la información capturada para tener un apoyo visual que permita solucionar los problemas que enfrentan los hospitales.

# Problem Domain

El alcance de Voxxmap es global, por lo que ciertas regiones en las que  opera presentan retos adicionales. En el caso de los países en vías de desarrollo, existen limitantes sociales, tecnológicas y económicas. Además, se presentan retos tecnológicos en la creación de la base de datos y de la recopilación de respuestas a las encuestas. 

1. _**Falta de infraestructura**_ Muchas regiones del mundo (medio oriente, latinoamérica, África y el sureste de Asia) no cuentan con la infraestructura adecuada para el levantamiento de datos. Se debe tener en cuenta que la aplicación en la que se maneja la encuesta debe ser lo más ligera posible y debe poder operar en circunstancias subóptimas. Voxxmap pretende brindar esta infraestructura remotamente, permitiendo un registro de datos seguro y eficiente.  
2. _**Falta de conocimiento**_ En los países en que no se cuenta con infraestructura gubernamental para el monitoreo de los patógenos como el COVID-19, la población general está menos informada y por ende la participación ciudadana tiende a ser más débil. La falta de recursos estatales implica además un vacío de información en los hospitales públicos, en donde los registros no son de fiar. El objetivo de Voxxmap en este ámbito es generar visiones alternas a las oficiales; además de levantar datos, se generarán vistas analíticas que permitan a los hospitales tomar decisiones y ejecutar sus planes de acción.  
3. _**Limitado acceso a la tecnología**_ Gran parte de la población de los países en vías de desarrollo no tiene un acceso continuo a los dispositivos electrónicos; por ende, le tecnología social tiene un alcance limitado en estas regiones. Voxxmap no puede asumir que las encuestas pueden ser respondidas por cualquiera, ni que todos cuentan con dispositivos capaces de correr un programa de encuestado. Se debe asumir que en los hospitales a los que se contacta se cuenta por lo menos con una computadora capaz de abrir una encuesta sencilla, pero siempre tomando en cuenta que puede sólo haber una y que puede no tener una conexión de internet estable. Voxxmap combatirá estas limitantes brindando la encuesta de manera telefónica en los lugares que no cuenten con dispositivos capaces y desplegando encuestas digitales ligeras. 
4. _**Falta de colaboración social**_ Además de la nula colaboración estatal, las regiones más desfavorecidas también tienen poblaciones menos dispuestas a colaborar en proyectos de este estilo. Ya sea porque no conocen los detalles que se les preguntan o porque simplemente no quieren contestar, es una cuestión que se debe tomar en cuenta. Posiblemente dos contactos con el mismo hospital puedan rendir resultados distintos dependiendo de quién conteste la llamada o la encuesta en cada ocasión. Esto se enfrentará a través de un análisis consolidador y conciliador entre los resultados distintos que arroja cada intento de encuesta en un hospital determinado.  
5. _**Diseño de una BD segura y eficiente**_ Es un reto crear una base de datos para cumplir los requisitos que impone un proyecto como este. A pesar de que exiten tecnologías y APIs que permiten la integración de los métodos de encuestado populares a las bases de datos de SQL, se presentan problemas de índole técnica que se deben enfrentar. 


