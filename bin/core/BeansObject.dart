class BeansObject {
    final String name;
    final String keyCode;
    final Map<String, BeansObjectProperty> properties;
    final Map<String, BeansObjectMethod> methods;
    const BeansObject(this.name, this.keyCode, this.properties, this.methods);
}

class BeansObjectProperty {
    final String name;
    final bool canGet;
    final bool canSet;
    const BeansObjectProperty(this.name, this.canGet, this.canSet);
}

class BeansObjectMethod {
    final String name;
    final bool returnsValue;
    const BeansObjectMethod(this.name, this.returnsValue);
}