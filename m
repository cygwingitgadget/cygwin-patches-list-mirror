From: DJ Delorie <dj@delorie.com>
To: juliano@cs.unc.edu
Cc: cygwin-patches@sources.redhat.com
Subject: Re: cinstall contribution
Date: Fri, 14 Jul 2000 10:13:00 -0000
Message-id: <200007141712.NAA14485@envy.delorie.com>
References: <Pine.SGI.4.10.10007111450500.361924-100000@cystine.cs.unc.edu> <396B7FC4.188536DC@delorie.com> <200007112129.RAA03821@envy.delorie.com> <396F377E.F3ADDEF6@cs.unc.edu>
X-SW-Source: 2000-q3/msg00012.html

Thanks for getting involved!

> Unfortunately, there is a big problem with this patch.  `root_dir' isn't
> known yet when do_site is called.

It should be.  The root dialog comes before the site dialog.  The only
time it doesn't is when you're downloading without installing.

>   o Read from the registry the value of `/'.  Scary and perhaps too
>     limiting.

See mount.h.  It has a function to find the existing root mount point
(this is what root.cc does anyway).  So, if root_dir is NULL, try
find_root_mount().  If that fails also (i.e. no previous
installation), just don't pre-select a site.

> Then again, if the ToDo list includes caching the install location
> for use as default next time, that could be integrated with
> finishing my patch.

The root_dir *is* the previous install location, if you're doing an
update.  That's how the root dialog gets filled in by default.

> Also, please point me to a reference explaining the ChangeLog conventions
> that you follow.  I know about standards.info, but it's kind of skimpy. 
> What do y'all do to ensure you don't miss mentioning a changed function?

YYYY-MM-DD<sp><sp>Full Name<sp><sp><email@address>

I do a "cvs diff -p2" just before committing anything, and review the
diff to make sure the ChangeLog is complete.  Your actual entry looks
fine.

A note on coding style:  I prefer that when you test for an error
(like the results of fopen), you test for the error case,
not the success case.  That way you don't end up indenting a lot.
For example, your code is like this:

+  if (f)
+    {
+      char line[1000];
+      if (fgets (line, 1000, f))
+	sscanf (line, "%s", site);
+      fclose (f);
+    }

What I'd do is test the other way:

+   if (!f)
+     return;
+   fgets (site, 1000, f);
+   fclose (f);

Of course, I don't do it that way when the function has more work to
do, but in this case it doesn't - if the file is missing, no more work
needs to be done, so why not just return right away?

Note that the "main" code is always at the same indent level.  Note
also that I didn't bother with the intermediate "line" variable;
there's no need.

+  if (site)

Since "site" is an array, this test will always be true.  I think what
you wanted was "if (site[0])" but you don't need that anyway.  If site
is an empty string, it just won't match anything from the list.

Also, you don't need to pass "HINSTANCE h" to get_initial_list_idx
because it doesn't need it.

You also don't handle the case where the user selects "other" and
fills in the URL in other.cc.  Perhaps save_mirror_site should be
called by both dialogs?
