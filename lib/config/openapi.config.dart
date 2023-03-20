import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
        DioProperties(pubName: 'todo_api', pubAuthor: 'Mothusi Molorane'),
    inputSpecFile: 'todo-spec.yaml',
    generatorName: Generator.dio,
    overwriteExistingFiles: true,
    outputDirectory: 'openapi',
    alwaysRun: true)
class OpenApiConfig extends OpenapiGeneratorConfig {}
