Return-Path: <cygwin-patches-return-3495-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28087 invoked by alias); 5 Feb 2003 14:50:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28048 invoked from network); 5 Feb 2003 14:50:12 -0000
Date: Wed, 05 Feb 2003 14:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sec_acl.cc
Message-ID: <20030205145009.GT5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00144.txt.bz2

On Wed, Feb 05, 2003 at 09:15:05AM -0500, Pierre A. Humblet wrote:
> is_grp_member is now unused and will disappear in the next installment.

You did it ;-)

> Three remarks:
> 1) I changed a STANDARD_RIGHTS_ALL to STANDARD_RIGHTS_WRITE in setacl.
>    Is that what you meant?

I don't know what you mean by "Is that what you meant?".  What are you
referring to?  However, it's incorrect.  The permission to write does
include all standard rights.  So the STANDARD_RIGHTS_ALL is correct.

> 2) Because of the ~DELETE stuff in setacl, the owner may not have DELETE
> right, 
>    even when the file is writable. unlink calls chmod if needed so it's OK

I think you misinterpreted the code slightly.  Some lines earlier, the
Win32 permissions are set according to the POSIX permissions.  The right
to write includes STANDARD_RIGHTS_ALL which includes the right to DELETE.

In the lines you're referring to, the owner of the file gets the
STANDARD_RIGHTS_ALL, regardless of the permission bits set some lines
earlier.  However, the right to DELETE is only set in conjunction with
the write permisssion.  It must not be set unconditionally in these lines.

So everything's fine if you don't change STANDARD_RIGHTS_ALL to
STANDARD_RIGHTS_WRITE some lines before ;-)

> 3) In security.cc I had to move set_process_privilege back to write_sd
>    because setacl may need it.

That's ok.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
