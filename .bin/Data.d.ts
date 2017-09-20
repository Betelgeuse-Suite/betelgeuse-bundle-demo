declare namespace Beetlejuice {
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
                    "another-value": number;
                };
            };
        };
    }
}
export = Beetlejuice;