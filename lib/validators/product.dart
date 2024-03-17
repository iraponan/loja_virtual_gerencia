mixin ProductValidator {
  String? validateImages(List? images) {
    if (images == null || images.isEmpty) return 'Adicione imagens ao produto.';
    return null;
  }

  String? validateTitle(String? text) {
    if (text == null || text.isEmpty) return 'Preencha o título do produto.';
    return null;
  }

  String? validateDescription(String? text) {
    if (text == null || text.isEmpty) return 'Preencha a descrição do produto.';
    return null;
  }

  String? validatePrice(String? text) {
    double? price = double.tryParse(
        text?.replaceAll('R\$ ', '')
             .replaceAll('.', '')
             .replaceAll(',', '.')
             ?? '');
    if (price == null || price.isNaN || price == 0.0) {
      return 'Preço inválido.';
    } else {
      return null;
    }
  }

  String? validateSize(List? sizes) {
    if (sizes == null || sizes.isEmpty) return 'Adicione pelo menos um tamanho.';
    return null;
  }
}
