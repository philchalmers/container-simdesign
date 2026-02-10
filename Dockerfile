FROM rocker/r-base:latest

LABEL org.opencontainers.image.source=https://github.com/philchalmers/container-simdesign
LABEL org.opencontainers.image.description="Container for running SimDesign tests and R CMD check"
LABEL org.opencontainers.image.licenses=MIT

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    sudo \
    pandoc \
    qpdf \
    libcairo2-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libharfbuzz-dev libfribidi-dev \
    libfontconfig1-dev libpango1.0-dev \
    libxml2-dev \
    libtiff-dev \
    && rm -rf /var/lib/apt/lists/*

# install e1071 first
RUN Rscript -e "install.packages('e1071')"

# Install R packages from CRAN
RUN echo 'install.packages(c(' >> install_packages.R && \
  echo '"devtools", "dplyr", "httpgd", "languageserver",' >> install_packages.R && \
  echo '"modsem", "SimDesign", "roxygen2", "rmarkdown",' >> install_packages.R && \
  echo '"markdown", "pkgdown", "usethis", "rcmdcheck",' >> install_packages.R && \
  echo '"rversions", "urlchecker", "tinytex"' >> install_packages.R && \
  echo '))' >> install_packages.R
RUN Rscript install_packages.R
