import 'package:flutter/material.dart';

class TelaConsultaExtintor extends StatefulWidget {
  const TelaConsultaExtintor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TelaConsultaExtintorState createState() => _TelaConsultaExtintorState();
}

class _TelaConsultaExtintorState extends State<TelaConsultaExtintor> {
  // Controladores para campos de texto
  final TextEditingController _patrimonioController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _codigoFabricanteController =
      TextEditingController();
  final TextEditingController _dataValidadeController = TextEditingController();
  final TextEditingController _ultimaRecargaController =
      TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();

  // Variáveis para Dropdowns
  String? _selectedCapacidade;
  String? _selectedStatus;
  String? _selectedLinha;

  // Lista de opções
  final List<String> capacidades = ['11/2', '21/2', '1Kg','2Kg','4Kg','6Kg','8Kg', '10Kg', '10L','12Kg','20Kg','25Kg','45Kg','50Kg'];
  final List<String> statusOptions = ['Ativo', 'Violado', 'Vencido'];
  final List<String> linhas = ['Linha Verde', 'Linha Azul', 'Linha Vermelha'];

  // Função para abrir o calendário e selecionar a data
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // Função de busca ao clicar no botão "Buscar"
  void _buscar() {
    print("Patrimônio: ${_patrimonioController.text}");
    print("Tipo: ${_tipoController.text}");
    print("Capacidade: $_selectedCapacidade");
    print("Código do Fabricante: ${_codigoFabricanteController.text}");
    print("Data de Validade: ${_dataValidadeController.text}");
    print("Última Recarga: ${_ultimaRecargaController.text}");
    print("Status: $_selectedStatus");
    print("Linha: $_selectedLinha");
    print("Localização: ${_localizacaoController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011689),
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpeg',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              'Consulta',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFF011689), // Cor de fundo
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Preencha os campos para consultar',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black12,
                        thickness: 1,
                      ),
                      // Novo campo Patrimônio
                      _buildTextField('Patrimônio', _patrimonioController),
                      _buildTextField('Tipo', _tipoController),
                      _buildDropdownField('Capacidade', capacidades,
                          _selectedCapacidade, (value) {
                        setState(() {
                          _selectedCapacidade = value;
                        });
                      }),
                      _buildTextField('Código do Fabricante',
                          _codigoFabricanteController),
                      _buildDateField(
                          'Data de Validade', _dataValidadeController),
                      _buildDateField(
                          'Última Recarga', _ultimaRecargaController),
                      _buildDropdownField(
                          'Status', statusOptions, _selectedStatus, (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      }),
                      _buildDropdownField('Linha', linhas, _selectedLinha,
                          (value) {
                        setState(() {
                          _selectedLinha = value;
                        });
                      }),
                      _buildTextField('Localização', _localizacaoController),
                      const SizedBox(height: 16),
                      // Botão de busca
                      ElevatedButton(
                        onPressed: _buscar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF011689), // Cor do botão
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Buscar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para criar campos de texto
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Função para criar dropdowns
  Widget _buildDropdownField(String label, List<String> items,
      String? selectedItem, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedItem,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  // Função para criar campos de data
  Widget _buildDateField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.none,
        onTap: () {
          _selectDate(context, controller); // Abre o calendário ao tocar no campo
        },
      ),
    );
  }
}