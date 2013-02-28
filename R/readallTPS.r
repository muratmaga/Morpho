readallTPS <- function(file)
  {
    out=list()
    exOut <- FALSE
    noutline <- 0
    input <- readLines(file)
### get Landmark infos
    LM <- grep("LM=",input)
    LMstring <- input[LM]
    nLM <-sapply(LMstring,strsplit,split="=")
    nLM <- unlist(nLM)
    nLM <- as.integer(nLM[-which(nLM == "LM")])
    nobs <- length(nLM)
### get ID infos
    ID <- grep("ID=",input)
    IDstring <- input[ID]
    nID <-sapply(IDstring,function(x){x <- gsub("=","_",x)})
    nID <- unlist(nID)
                                        #nID <- nID[-which(nID == "ID")]
    ##nobs <- length(nID)
    out$ID <- nID
    
### get outline infos
    outline <- grep("OUTLINES=",input)
    if (length(outline) > 0)
      {
        exOut <- TRUE
        outlinestring <- input[outline]
        noutline <-sapply(outlinestring,strsplit,split="=")
        noutline <- unlist(noutline)
        noutline <- as.integer(noutline[-which(noutline == "OUTLINES")])
        LMoutline <- (sapply(outline,function(x){x <- max(which(LM < x))}))
      }
### extract Landmarks
    LMdata <- list()
    for ( i in 1:nobs)
      {
        if (nLM[i] > 0)
          {
            LMdata[[i]] <- as.numeric(unlist(strsplit(unlist(input[c((LM[i]+1):(LM[i]+nLM[i]))]),split=" ")))
            LMdata[[i]] <- matrix(LMdata[[i]],nLM[i],2,byrow = TRUE)
          }
        else
          LMdata[[i]] <- NA
      }
    names(LMdata) <- nID
    out$LM <- LMdata

### extract outlines
    if (exOut)
      {
        outlineData <- list()
        
        for ( i in 1:nobs)
          {
            if (i %in% LMoutline)
              {
                i1 <- grep(i,LMoutline)
                outlinetmp <- list()
                ptr <- outline[i1]+1
                
                j <- 1
                while (j <= noutline[i1])
                  {
                    tmpnr <- as.integer(unlist(strsplit(input[ptr],split="="))[2])
                                        #printmpnr)
                    outlinetmp[[j]] <-matrix(as.numeric(unlist(strsplit(input[(ptr+1):(ptr+tmpnr)],split=" "))),tmpnr,2,byrow=TRUE)
                    ptr <- ptr+tmpnr+1
                    j <- j+1
                  }
                outlineData[[i]] <- outlinetmp
              }
            else
              outlineData[[i]] <- NA
          }
        names(outlineData) <- nID
        out$outlines <- outlineData
      }
    cat(paste("Read",nobs,"datasets with",sum(noutline),"outlines\n"))
    return(out)
  }
