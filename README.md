# docker-image-compression

This docker container takes multiple different image compression containers and combines them into one. 

Convert from PNG to:
- JPEG (via [Guetzli](https://github.com/google/guetzli))
- JPEG2000 (via [OpenJPEG](https://github.com/uclouvain/openjpeg))
- [WebP](https://github.com/webmproject/libwebp)

## Usage
Pull the image:
`docker pull tabrindle/docker-image-compression`

Run with mounted volumes, and a given file or directory
Ex: `docker run -v $(pwd):/tmp --rm tabrindle/docker-image-compression test/test.png`

Will result in the following files:
- test-guetzli.jpg
- test-original.png
- test.jp2
- test.webp

## Credits 

- https://github.com/fabiang/docker-guetzli (Uses full Ubuntu)
- https://github.com/jveldboom/docker-google-guetzli
- https://github.com/awyl/alpine-google-guetzli (Uses Alpine, but no WebP or JPEG2000)
