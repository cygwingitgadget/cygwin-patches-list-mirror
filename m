Return-Path: <cygwin-patches-return-3330-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31853 invoked by alias); 16 Dec 2002 18:01:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31809 invoked from network); 16 Dec 2002 18:01:09 -0000
Message-ID: <3DFE151D.B657F3EF@ieee.org>
Date: Mon, 16 Dec 2002 10:01:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: security.cc and sec_acl.cc (ntsec, inheritance and sec_acl)
References: <3.0.5.32.20021205222631.007d3920@mail.attbi.com> <20021210112403.B7796@cygbert.vinschen.de> <3DFDF1C4.575D6360@ieee.org> <20021216184320.H19104@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00281.txt.bz2

Corinna Vinschen wrote:
> 
> Hi Pierre,
> 
> On Mon, Dec 16, 2002 at 10:31:16AM -0500, Pierre A. Humblet wrote:
> > I have a question: there is code in setacl (new line 139) to merge non-default
> > ACE's with previous default ACEs.
> > As the acl was sorted, I don't see how that code can ever be exercised.
> > Should we try to merge default ACEs with non-default ones? I am not sure it's
> > worth it.
> 
> the answer is "yes".
> 
> The incoming acls are Sun acls.  They could look like this:
> 
>    ...
>    user:foo:rw-
>    ...
>    default:user:foo:rw-
> 
> That is a sorted acl, right?  When converting this into a Windows ACL
> I'd like to see this as just one ACL, having the correct permissions
> *plus* the inheritance attribute.  I don't see how that's incorrect?!?
> 

It's correct, and it's apparently being done already (see below).
But frankly I don't understand why it happens!
The default is merged with a previous non-default.
I only see Cygwin code to merge a non-default with a previous default.

Pierre

/> mkdir abcd
/> setfacl -s u::rwx,g::rwx,o::rwx,u:testuser:r--,d:u:testuser:r-- abcd
/> getfacl abcd
# file: abcd
# owner: PHumblet
# group: Clearusers
user::rwx
user:testuser:r--
group::rwx
mask:rwx
other:rwx
default:user:testuser:r--
default:mask:rwx
/> cacls abcd
e:\abcd DOMAIN\PHumblet:F 
        PHumblet\testuser:(OI)(CI)(special access:)
                                  READ_CONTROL
                                  SYNCHRONIZE
                                  FILE_GENERIC_READ
                                  FILE_READ_DATA
                                  FILE_READ_EA
                                  FILE_READ_ATTRIBUTES
 
        DOMAIN\Clearusers:F 
        Everyone:F 


> Corinna
