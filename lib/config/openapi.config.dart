import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: AdditionalProperties(
        pubName: 'todo_api', pubAuthor: 'Mothusi Molorane'),
    inputSpecFile: 'todo-spec.yaml',
    generatorName: Generator.dart,
    overwriteExistingFiles: true,
    outputDirectory: 'lib/openapi',
    alwaysRun: true)
class OpenApiConfig extends OpenapiGeneratorConfig {}
