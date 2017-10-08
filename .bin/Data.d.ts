declare namespace Betelgeuse {
    interface Data {
        "index": {
            "source": string;
            "test": string;
            "tesyy": string;
        };
        "nested": {
            "nested": {
                "file": {
                    "value": number;
                    "anotherValue": number;
                };
            };
        };
    }
}
export = Betelgeuse;