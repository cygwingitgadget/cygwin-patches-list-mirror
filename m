From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch: More options for regtool
Date: Wed, 10 Jan 2001 05:29:00 -0000
Message-id: <20010110082944.A25695@redhat.com>
References: <000601c07ae7$404bd700$0200a8c0@fred>
X-SW-Source: 2001-q1/msg00021.html

On Wed, Jan 10, 2001 at 01:25:19AM -0800, Tony Sideris wrote:
>PS: I apoligize if i missed something. I read the FAQs on contributing, hope
>i got it all...

Actually, please go back and read the Contributing web page again.  The
entry below is not correct.  If you could tell me where I got things
wrong, I'll try to clarify the information on the contrib.html web page.

Specifically, there should not be multiple lines for "global", the file
should only be listed once, and the entries should begin with a tab.

Thanks for your submission, though.  We'll evaluate the patch itself soon.

cgf

>Tue Jan 09 10:26:23 2001  Tony Sideris  <tonys1110@home.com>
>
> * regtool.cc (global): Add LIST_KEYS, LIST_VALS, and LIST_ALL
> constants.
> * regtool.cc (global): Add int listwhat, and int postfix.
> * regtool.cc (global): Modify usage_msg to document -p, -k, and -l.
> * regtool.cc (Fail): Add call to LocalFree to free memory
> allocated by FormatMessage (unrelated to new options).
> * regtool.cc (cmd_list): Add code to implement -p, -k, and -l
> options, this involved checking 'listwhat' and 'postfix' and
> acting accordingly.
> * utils.sgml: Updated usage message to reflect the new options.
>




-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
