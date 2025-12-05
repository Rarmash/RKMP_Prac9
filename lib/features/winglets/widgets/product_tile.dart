import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const ProductTile({
    super.key,
    required this.product,
    this.onDelete,
    this.onTap,
  });

  String _getProductImageUrl(int id) {
    switch (id) {
      case 1:
        return 'https://avatars.mds.yandex.net/get-mpic/4267432/2a00000192e1b8f63620001e7e1a5f66d9b0/optimize';
      case 2:
        return 'https://avatars.mds.yandex.net/get-mpic/15269583/2a0000019a4d23454f6c5513775ae41c5e3d/optimize';
      case 3:
        return 'https://avatars.mds.yandex.net/get-mpic/1522540/2a00000197f3635802c8ab9c0f32488900cd/optimize';
      case 4:
        return 'https://avatars.mds.yandex.net/get-mpic/1930823/2a0000019248ecbcbb91e0d76660492391b9/optimize';
      case 5:
        return 'https://avatars.mds.yandex.net/get-mpic/12200529/2a0000018cee2810436ee79689e1e18b62dd/optimize';
      default:
        return 'https://avatars.mds.yandex.net/i?id=b89aab1fa0a115ab506ad87336234073_l-4271783-images-thumbs&n=13';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      elevation: 3,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: _getProductImageUrl(product.id),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
            const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
          ),
        ),
        title: Text(product.name, style: const TextStyle(fontSize: 18)),
        subtitle: Text('Количество: ${product.quantity}'),
        trailing: onDelete != null
            ? IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        )
            : null,
      ),
    );
  }
}
