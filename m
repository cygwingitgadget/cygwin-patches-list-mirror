Return-Path: <cygwin-patches-return-4244-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31538 invoked by alias); 26 Sep 2003 12:53:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31522 invoked from network); 26 Sep 2003 12:53:29 -0000
Date: Fri, 26 Sep 2003 12:53:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Recent security improvements breaks proftpd
Message-ID: <20030926125328.GB29894@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00260.txt.bz2

On Thu, Sep 25, 2003 at 08:46:53PM -0400, Pierre A. Humblet wrote:
> 2003-09-25  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* uinfo.cc (cygheap_user::init): Make sure the current user appears
> 	in the default DACL. Rearrange to decrease the indentation levels. 
> 	Initialize the effec_cygsid directly.
> 	(internal_getlogin): Do not reinitialize myself->gid. Open the process
> 	token with the required access.
> 	* cygheap.h (class cygheap_user): Delete members pid and saved_psid.
> 	Create members effec_cygsid and saved_cygsid.
> 	(cygheap_user::set_sid): Define inline.
> 	(cygheap_user::set_saved_sid): Ditto.
> 	(cygheap_user::sid): Modify.
> 	(cygheap_user::saved_sid): Modify.
> 	* cygheap.cc (cygheap_user::set_sid): Delete.
> 	(cygheap_user::set_saved_sid): Ditto.
> 	* sec_helper.cc (sec_acl): Set the correct acl size.
> 	* autoload.cc (FindFirstFreeAce): Add.

Approved with two changes:

> Index: uinfo.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
> retrieving revision 1.120
> diff -u -p -r1.120 uinfo.cc
> --- uinfo.cc	25 Sep 2003 00:37:17 -0000	1.120
> +++ uinfo.cc	26 Sep 2003 00:11:35 -0000
> @@ -41,31 +41,63 @@ cygheap_user::init()
> 
>    set_name (GetUserName (user_name, &user_name_len) ? user_name : "unknown");
> 
> -  if (wincap.has_security ())
> +  if (!wincap.has_security ())
> +    return;
> +
> +  HANDLE ptok;
> +  DWORD siz;
> +  char buf [1024];

In sec_acl.cc and security.cc, this buffer is named `acl_buf' and it's
size is 3072.  Let's do it the same here.  I've seen amazingly big ACLs
on NT4 once.

> +      else if (pAcl->AclSize = (char *) pAce - (char *) pAcl,
> +	       !SetTokenInformation (ptok, TokenDefaultDacl, pdacl, sizeof (buf)))
> +	system_printf ("SetTokenInformation (TokenDefaultDacl): %E");

Please make this:

   else
     {
       pAcl->AclSize = (char *) pAce - (char *) pAcl;
       if (!SetTokenInformation (...))
	system_printf (...);
     }

Btw., shouldn't that be

  SetTokenInformation (ptok, TokenDefaultDacl, pdacl, pAcl->AclSize)
                                                      ^^^^^^^^^^^^^
						      instead of sizeof(buf)?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
