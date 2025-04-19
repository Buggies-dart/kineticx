import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Helper/target_body_parts_filter.dart';

class ExploreController{

// Best For You
static final targetedPodyPart = FutureProvider<List<Map<String, dynamic>>>((ref) async {
return await getbodyPartFilter();
});
}