FROM rocker/r-base:latest

LABEL org.opencontainers.image.source=https://github.com/philchalmers/container-simdesign
LABEL org.opencontainers.image.description="Container for running SimDesign tests and R CMD check"
LABEL org.opencontainers.image.licenses=MIT

RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-broken \
    git \
    sudo \
    pandoc \
    qpdf \
    cmake \
    libcairo2-dev \
    libfreetype-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libssl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfontconfig1-dev \
    libpango1.0-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libuv1-dev \
    ibmagick++-dev \
    libprotobuf-dev \
    #libcurl4-openssl-dev \
    libcurl4-gnutls-dev \
    && rm -rf /var/lib/apt/lists/* 

# global def
RUN echo _R_CHECK_FORCE_SUGGESTS_=FALSE

# for tests
RUN Rscript -e "install.packages(c('SimDesign', 'extraDistr', 'testthat', 'devtools'))"

# Install R packages from CRAN
RUN echo 'install.packages(c(' >> install_packages.R && \
  echo '"e1071", "dplyr", "httpgd", "languageserver",' >> install_packages.R && \
  echo '"modsem", "roxygen2", "rmarkdown",' >> install_packages.R && \
  echo '"markdown", "pkgdown", "usethis", "rcmdcheck",' >> install_packages.R && \
  echo '"rversions", "urlchecker", "tinytex", "stringfish", "qs2"' >> install_packages.R && \
  echo '))' >> install_packages.R
RUN Rscript install_packages.R
