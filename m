From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Tue, 08 May 2001 19:41:00 -0000
Message-id: <20010508223955.D29266@redhat.com>
References: <VA.00000757.0015edd1@thesoftwaresource.com> <20010508000842.A3591@redhat.com> <VA.0000075b.00481c6e@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00206.html

On Tue, May 08, 2001 at 09:23:38PM -0400, Brian Keener wrote:
>> I don't know if this is a new problem of if setup.exe has always
>> worked like this, but this is a bug that could theoretically cause
>> us problems.  Anyone want to look at this one?
>
>I'm not sure I ever noticed and/or knew where they go when installed.  I 
>vaguely remember a change being discussed not long ago about changing 
>and/or making it operator specified where the source was installed - but 
>I haven't checked the ChangeLog yet.  It will be a few days for me to get 
>a chance to check if anyone else wants a shot.

I don't care if the location is fixed, it should just honor the cygwin mount
table.

cgf
