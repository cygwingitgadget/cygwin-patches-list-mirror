From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: a weird behavior on a command prompt.
Date: Wed, 13 Sep 2000 11:29:00 -0000
Message-id: <20000913142841.C17331@cygnus.com>
References: <s1s66o0jnd3.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00084.html

On Thu, Sep 14, 2000 at 12:57:44AM +0900, Kazuhiro Fujieda wrote:
>Cygwin commands invoked with quotation marks on a command prompt
>ignore the first argument as the following:
>
>Microsoft(R) Windows NT(R)
>(C) Copyright 1985-1996 Microsoft Corp.
>
>C:\Home\fujieda>ls --version
>ls (GNU fileutils) 3.16
>
>C:\Home\fujieda>"ls" --version
>bin        doc        lib        tmp
>cygwin     gdbtk.ini  mp3        work

If I'm reading your patch correctly, the only thing that really needed
to be done was to

return p;

rather than

return p + 1;

That is the change that I've made.

Thanks,
cgf


>ChangeLog:
>Thu Sep 14 00:37:46 2000  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	*  dcrt0.cc (quoted): Handle quoted first argument properly.
>
>Index: dcrt0.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
>retrieving revision 1.55
>diff -u -p -r1.55 dcrt0.cc
>--- dcrt0.cc	2000/09/10 16:43:47	1.55
>+++ dcrt0.cc	2000/09/13 15:26:46
>@@ -303,11 +303,16 @@ quoted (char *cmd, int winshell)
> 
>   if (!winshell)
>     {
>-      char *p;
>-      strcpy (cmd, cmd + 1);
>-      if ((p = strchr (cmd, quote)) != NULL)
>-	strcpy (p, p + 1);
>-      return p + 1;
>+      size_t len = strlen (cmd);
>+      memmove (cmd, cmd + 1, len);
>+      p = strchr (cmd, quote);
>+      if (!p)
>+	return cmd;
>+      else
>+	{
>+	  memmove (p, p + 1, len - 1 - (p - cmd));
>+	  return p;
>+	}
>     }
> 
>   /* This must have been run from a Windows shell, so preserve
