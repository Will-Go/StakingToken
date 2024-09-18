Smart Contract Staking de KipuCoin

Descripción:
Este repositorio contiene un Smart Contract de Staking desarrollado en Solidity para el token ERC-20 KipuCoin (KPC). Este proyecto fue creado con fines didácticos por los estudiantes Wilson Gong Wu, Nicolas Flórez Jiménez y Alessandro Colagrosso Fittipaldi, y busca proporcionar una comprensión práctica sobre cómo funcionan los contratos inteligentes en el contexto de la blockchain.
El contrato permite a los usuarios realizar staking de sus tokens, lo que les da la oportunidad de ganar recompensas en forma de tokens adicionales. A través de este sistema, los usuarios pueden maximizar el rendimiento de sus activos en un entorno seguro y transparente.

Características principales:
Stake de Tokens: Los usuarios pueden hacer staking de sus tokens KPC, lo que les permite ganar recompensas pasivas.
Generación de Recompensas: Las recompensas se calculan en función de la cantidad de tokens en staking y el tiempo que se han mantenido.
Desstake Flexible: Los usuarios tienen la libertad de retirar sus tokens en cualquier momento, lo que proporciona flexibilidad en la gestión de sus inversiones.
Control del Propietario: El propietario del contrato tiene la capacidad de ajustar la tasa de recompensa, permitiendo la adaptación a diferentes condiciones del mercado.

Uso:
Una vez que el contrato esté desplegado, los usuarios pueden interactuar con él a través de scripts de JavaScript, la consola de Truffle, o una interfaz de usuario que implementes. A continuación se presentan algunos ejemplos de cómo usar las funciones principales del contrato.

Funciones Disponibles:

1. `stake(uint256 amount)`
Descripción: Esta función permite a los usuarios hacer staking de una cantidad específica de tokens KPC. 
Parámetro: `amount`: La cantidad de tokens KPC que el usuario desea stakear. Este valor debe ser mayor que cero.
 Proceso:
  -Validación: Primero, la función verifica que el `amount` sea mayor que cero.
- Cálculo de Recompensas: Antes de hacer el staking, la función llama a `calculateReward` para determinar si el usuario tiene recompensas pendientes y las reclama si es necesario.
  -Transferencia de Tokens: Los tokens KPC se transfieren del saldo del usuario al contrato, lo que significa que el usuario ya no puede usarlos hasta que los retire.
  - Actualización de Estado: La información sobre el staking del usuario se actualiza, incluyendo la cantidad de tokens en staking y el timestamp actual.
Eventos: Emite un evento `Staked`, que proporciona información sobre la dirección del usuario y la cantidad de tokens que han sido stakeados.

2. `unstake(uint256 amount)`
Descripción: Esta función permite a los usuarios retirar una cantidad específica de tokens KPC de su staking.
Parámetro: `amount`: La cantidad de tokens KPC que el usuario desea retirar del staking. Este valor debe ser menor o igual a la cantidad actualmente stakeada por el usuario.
Proceso:
  - Validación: Se verifica que el usuario tenga suficientes tokens en staking para realizar la operación.
  - Cálculo de Recompensas: Similar a la función `stake`, se calculan las recompensas pendientes antes de proceder con el unstaking.
  - Actualización de Estado: Se reduce la cantidad de tokens en staking y se actualizan los registros de recompensas.
  - Transferencia de Tokens: Finalmente, los tokens KPC son transferidos de vuelta al usuario desde el contrato.

- Eventos: Emite un evento `Unstaked`, que notifica sobre la dirección del usuario y la cantidad de tokens que han sido retirados.

3. `calculateReward(address stakerAddress)`
Descripción: Esta función calcula las recompensas pendientes acumuladas para un staker específico.
Parámetro:`stakerAddress`: La dirección del usuario para el cual se desea calcular las recompensas.
Proceso:
  - Acceso a Datos: La función accede a la estructura de datos `Staker` correspondiente a la dirección proporcionada.
  - Cálculo de Tiempo de Staking: Se determina cuánto tiempo ha pasado desde que el usuario hizo su última acción de staking.
  - Cálculo de Recompensas: Se aplica una fórmula que multiplica la cantidad de tokens en staking, la tasa de recompensa y el tiempo transcurrido, ajustado por un factor de escalado (1e18) para evitar problemas de precisión.
- Retorno: Devuelve el total de recompensas acumuladas en tokens KPC que el usuario puede reclamar.

4. `setRewardRate(uint256 newRate)`
Descripción: Esta función permite al propietario del contrato ajustar la tasa de recompensa por staking.
Parámetro: `newRate`: El nuevo valor de la tasa de recompensa, especificado en tokens por segundo.
Proceso:
  - Control de Acceso: Solo el propietario del contrato puede ejecutar esta función, asegurando que no cualquier usuario pueda modificar la tasa de recompensa.
  - Actualización de Tasa: Se actualiza el valor de la variable `rewardRate` con el nuevo valor proporcionado.
- Uso: Esta función es útil para adaptarse a condiciones cambiantes del mercado o para ajustar las recompensas en función del comportamiento de los usuarios.


Licencia:
Este proyecto está licenciado bajo la Licencia MIT. 

Contacto:
Para preguntas, sugerencias o comentarios, puedes contactar a los autores:
    • Wilson Gong Wu
    • Nicolas Flórez Jimenez
    • Alessandro Colagrosso Fittipaldi
    
