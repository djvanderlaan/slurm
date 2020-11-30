
lines <- readLines("slurm_jobacct.log")

spllines <- strsplit(lines, " ")

header <- t(sapply(spllines, function(d) d[1:6]))
header <- as.data.frame(header, stringsAsFactors = FALSE)
head(header)

#JobId, UserId=name(uid), GroupId=name(gid), Name, JobState, Partition,
#TimeLimit, StartTime, EndTime, NodeList, NodeCnt, ProcCnt, WorkDir.

names(header) <- c("jobid", "partition", "starttime", "endtime", "uid", 
  "gid")
header$jobid <- as.numeric(header$jobid)
header$starttime <- as.numeric(header$starttime)
header$endtime <- as.numeric(header$endtime)
header$uid <- as.numeric(header$uid)
header$gid <- as.numeric(header$gid)


head(header)

header$starttime <- as.POSIXct(header$starttime, origin  = "1970-01-01")
header$endtime <- as.POSIXct(header$endtime, origin  = "1970-01-01")

s <- sapply(spllines, function(d) d[9] == 0)
running <- do.call(rbind, spllines[s])
running <- as.data.frame(running, stringsAsFactors = FALSE)
names(running) <- c("jobid", "partition", "starttime", "endtime", "uid", 
  "gid", "V7", "V8", "status", "name", "V11", "mem", "cpucount", "nodes", "V15")
  
running$jobid <- as.numeric(running$jobid)
running$starttime <- as.numeric(running$starttime)
running$endtime <- as.numeric(running$endtime)
running$starttime <- as.POSIXct(running$starttime, origin  = "1970-01-01")
running$endtime <- as.POSIXct(running$endtime, origin  = "1970-01-01")
running$uid <- as.numeric(running$uid)
running$gid <- as.numeric(running$gid)
running$V7 <- NULL
running$V8 <- NULL
running$mem <- as.numeric(running$mem)


s <- sapply(spllines, function(d) d[9] == 3)
finished <- do.call(rbind, spllines[s])
finished <- as.data.frame(finished, stringsAsFactors = FALSE)
names(finished) <- c("jobid", "partition", "starttime", "endtime", "uid", 
  "gid", "V7", "V8", "status", "runtime", "result", "mem", "result2")
  
finished$jobid <- as.numeric(finished$jobid)
finished$starttime <- as.numeric(finished$starttime)
finished$endtime <- as.numeric(finished$endtime)
finished$starttime <- as.POSIXct(finished$starttime, origin  = "1970-01-01")
finished$endtime <- as.POSIXct(finished$endtime, origin  = "1970-01-01")
finished$uid <- as.numeric(finished$uid)
finished$gid <- as.numeric(finished$gid)
finished$V7 <- NULL
finished$V8 <- NULL
finished$status <- as.numeric(finished$status)
finished$runtime <- as.numeric(finished$runtime)
finished$result <- as.numeric(finished$result)
finished$result2 <- as.numeric(finished$result2)

finished$mem <- as.numeric(finished$mem)

