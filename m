From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] syscalls.cc for statfs/df under Win9x problem
Date: Tue, 13 Mar 2001 07:13:00 -0000
Message-id: <3AAE3916.45474F5F@yahoo.com>
References: <0GA500EHC3LE2O@pmismtp04.wcomnet.com> <20010313155155.C569@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00177.html

Corinna Vinschen wrote:
> 
> Chris, is that patch small enough to go in without copyright assignment?
> 
> On Mon, Mar 12, 2001 at 02:43:03PM -0700, Mark Paulus wrote:
> > Enclosed is a patch to fix the 2GB limit problem under Win9x
> > exhibited by df.  The only problem I can see is a failure with
> > repeated calls to a SMB share under WinME.  The first call to
> > statfs() gets good values, but the 2nd call returns some bogus
> > values.  I do not have access to a SMB share under Win2K
> > to see if it fails there also.
> 
> Mark,
> 
> I asked this already once you've send your first version. Did you
> try your patch with UNC paths? I'm asking because MSDN states
> that UNC paths must end with a backslash when using this function
> (\\server\share\). It would be really nice if you could have a look.
> 
> And two nags:
> 
> - Please remove the cvsId patch. We don't use it anywhere in the
>   sources.
> 
> - Could you please rearrange your patch so that it's according
>   to the GNU coding standard ( http://www.gnu.org/prep/standards_toc.html )
> 
>   For example, not so:  func( param ), func(param)
>   but so:               func (param)
> 
>   and not so:           if () {
>                           body
>                         } else {
>                         }
>   or                    if ()
>                         {
>                           body
>                         }
>                         else
>                         {
>                         }
>   but so:               if ()
>                           {
>                             body
>                           }
>                         else
>                           {
>                           }
> 

Sorry for asking on this list but this is an example of what I need. 
Does anyone know how to tell VIM to automagically do the above
indentation?  If I `:set cindent' it does the second "not so" and I
would like to change it to be correct.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

