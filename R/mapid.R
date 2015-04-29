## mappers

.mappers <- new.env(parent=emptyenv())

.mapper_add <- function(name, description)
    .mappers[[name]] <- description

.mapper_remove <- function(name)
    .mappers[[name]] <- NULL

.mapper_get_all <- function()
    as.list(.mappers)

.mapper_get <- function(name)
    .mappers[[name]]

.mapper_classes <- function()
{
    lapply(ls(.mappers), function(cls) {
        structure(list(), class=c(cls, "mapper"))
    })
}

## biomart

.mapid_resource.biomart <- function(cls, ...) {}

.mapid_from.biomart <- function(cls, resource, ...) {}

.mapid_to.biomart <- function(cls, resource, from, ...) {}

.mapid_ids.biomart <- function(cls, resource, from, to, ..., duplicates) {}

## mapid

.mapid_resource <- function(...) {}

mapid <-
    function(resource, from, to, ids, ..., duplicates)
{
    
}
