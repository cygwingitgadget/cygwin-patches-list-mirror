From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Avoid checking a magic number of a directory.
Date: Mon, 02 Apr 2001 07:35:00 -0000
Message-id: <20010402163532.K956@cygbert.vinschen.de>
References: <s1sk853h7fy.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00002.html

On Mon, Apr 02, 2001 at 08:22:57PM +0900, Kazuhiro Fujieda wrote:
> The following patch can speed up stat() a bit.
> 
> ChangeLog:
> 2001-04-02  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
> 
> 	* fhandler.cc (fhandler_disk_file::open): Avoid checking a magic
> 	number of a directory.
> 
> Index: fhandler.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
> retrieving revision 1.55
> diff -u -p -r1.55 fhandler.cc
> --- fhandler.cc	2001/03/13 13:07:15	1.55
> +++ fhandler.cc	2001/04/02 10:05:19
> @@ -1262,6 +1262,7 @@ fhandler_disk_file::open (path_conv& rea
>    extern BOOL allow_ntea;
>  
>    if (real_path.isdisk ()
> +      && !(real_path.file_attributes () & FILE_ATTRIBUTE_DIRECTORY)
>        && (real_path.exec_state () == dont_know_if_executable)
>        && !allow_ntea && (!allow_ntsec || !real_path.has_acls ()))
>      {
> 
> ____
>   | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>   | HOKURIKU  School of Information Science
> o_/ 1990      Japan Advanced Institute of Science and Technology

Thanks, applied,

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
