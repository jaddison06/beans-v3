class BeansObject {
    final String name;
    final String keyCode;
    final Map<String, BeansObjectProperty> properties;
    final Map<String, BeansObjectMethod> methods;
    const BeansObject(this.name, this.keyCode, this.properties, this.methods);

    BeansObject combo(BeansObject other) {
      final properties = Map.of(this.properties);
      final methods = Map.of(this.methods);
      for (var property in other.properties.entries) {
        if (!properties.containsKey(property.key)) {
          properties[property.key] = property.value;
        } else {
          properties[property.key]!.canGet =  property.value.canGet;
        }
      }
    }

    @override
    String toString() => '(BeansObject $keyCode) $name: {properties: $properties, methods: $methods}';
}

class BeansObjectProperty {
    final String name;
    final bool canGet;
    final bool canSet;
    const BeansObjectProperty(this.name, this.canGet, this.canSet);

    @override
    String toString() => '(BeansObjectProperty) $name: {canGet: $canGet, canSet: $canSet}';
}

class BeansObjectMethod {
    final String name;
    final bool returnsValue;
    const BeansObjectMethod(this.name, this.returnsValue);

    @override
    String toString() => '(BeansObjectMethod) $name: {returnsValue: $returnsValue}';
}