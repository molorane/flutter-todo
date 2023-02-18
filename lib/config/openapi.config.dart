import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: AdditionalProperties(
        pubName: 'todo_api', pubAuthor: 'Mothusi Molorane'),
    inputSpecFile: 'todo-spec.yaml',
    generatorName: Generator.dart,
    overwriteExistingFiles: false,
    outputDirectory: 'lib/openapi',
    alwaysRun: false)
class OpenApiConfig extends OpenapiGeneratorConfig {}
