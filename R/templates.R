# based off the rticles package from RStudio

#' R Markdown output format for pandoc-latex-template report
#'
#' Formats are based on \code{rmarkdown::pdf_document()}, with a
#' custom Pandoc LaTeX template and different default values for other arguments
#' (e.g., \code{keep_tex = TRUE}).
#'
#' @section Details: You can find more details about each output format below.
#' @name pandoc_latex_template
#' @rdname article
NULL

#' @section \code{pandoc_latex_template}: Format for creating an document adapted from
#'   \url{https://github.com/Wandmalfarbe/pandoc-latex-template}.
#' @param
#'   ...,keep_tex,latex_engine,citation_package,highlight,fig_caption,md_extensions
#'   Arguments passed to \code{rmarkdown::\link{pdf_document}()}.
#' @return An R Markdown output format.
#' @examples \dontrun{
#' rmarkdown::draft("MyArticle.Rmd", template = "pandoc_latex_template", package = "pandoclatextemplate")
#' }
#' @export
#' @rdname article
pandoc_latex_template <- function(dev = "pdf", template = template_resources('pandoc-latex-template', 'eisvogel.tex'), ...) {
  # function(documentclass = c('tufte-handout', 'tufte-book'),
  #                         fig_width = 4, fig_height = 2.5, fig_crop = TRUE,
  #                         dev = 'pdf', highlight = 'default',
  #                         citation_package = 'natbib', latex_engine = "pdflatex",
  #                         template = template_resources('tintPdf', 'tintPdf-template.tex'), ...) {

    ## resolve default highlight
    # if (identical(highlight, 'default')) highlight = 'pygments'

    # The template argument can either be a filename or a string specifying a
    # function call.
    # To decide which it is, we decide that it's a function call if both:
    # There's no file at that path;
    # The string looks like a legal function call: starts with a lexically
    # legal name followed by an open parenthesis, some stuff, and then ends with
    # a closing parenthesis.
    if (!file.exists(template) &&
        grepl("^[a-zA-Z_.][a-zA-Z0-9_.:]+\\(.*\\)$", template)) {
        template = eval(parse(text = template))
    }

    ## call the base pdf_document format with the appropriate options
    format <- rmarkdown::pdf_document(dev = dev, template = template, ...)
    # format <- rmarkdown::pdf_document(fig_width = fig_width, fig_height = fig_height,
    #                                   fig_crop = fig_crop, dev = dev, highlight = highlight,
    #                                   citation_package = citation_package,
    #                                   latex_engine = latex_engine,
    #                                   template = template, ...)

    ## LaTeX document class
    # documentclass = match.arg(documentclass)
    # format$pandoc$args <- c(
    #     format$pandoc$args, '--variable', paste0('documentclass:', documentclass),
    #     if (documentclass == 'tufte-book') "--top-level-division=chapter"
    # )
    #
    # knitr::knit_engines$set(marginfigure = function(options) {
    #     options$type = 'marginfigure'
    #     eng_block = knitr::knit_engines$get('block')
    #     eng_block(options)
    # })
    #
    # ## create knitr options (ensure opts and hooks are non-null)
    # knitr_options <- rmarkdown::knitr_options_pdf(fig_width, fig_height, fig_crop, dev)
    # if (is.null(knitr_options$opts_knit))  knitr_options$opts_knit = list()
    # if (is.null(knitr_options$knit_hooks)) knitr_options$knit_hooks = list()
    #
    # ## set options
    # knitr_options$opts_chunk$tidy = FALSE   ## TRUE implied formatR use
    # knitr_options$opts_knit$width = 45
    #
    # ## set hooks for special plot output
    # knitr_options$knit_hooks$plot <- function(x, options) {
    #
    #     ## determine figure type
    #     if (isTRUE(options$fig.margin)) {
    #         options$fig.env = 'marginfigure'
    #         if (is.null(options$fig.cap)) options$fig.cap = ''
    #     } else if (isTRUE(options$fig.fullwidth)) {
    #         options$fig.env = 'figure*'
    #         if (is.null(options$fig.cap)) options$fig.cap = ''
    #     }
    #
    #     knitr::hook_plot_tex(x, options)
    # }
    #
    # ## override the knitr settings of the base format and return the format
    # format$knitr <- knitr_options
    format$inherits <- 'pdf_document'
    format
}
