package pause_1999::startform;
use base 'Class::Singleton';
use pause_1999::main;

use strict;
use vars qw($VERSION);
$VERSION = sprintf "%d.%03d", q$Revision: 1.9 $ =~ /(\d+)\.(\d+)/;

sub as_string {
  my pause_1999::startform $self = shift;
  my pause_1999::main $mgr = shift;
  my @m;
  my $myurl = $mgr->myurl;
  my $me = $myurl->can("unparse") ? $myurl->unparse : $myurl->as_string;
  $me =~ s/\?.*//; # unparse keeps the querystring which breaks XHTML

  my $enctype;
  my $method;

  if ($mgr->can_multipart && $mgr->need_multipart) {
    $enctype = "multipart/form-data";
    $method = "post";
  } elsif ($mgr->prefer_post) {
    $enctype = "application/x-www-form-urlencoded";
    $method = "post";
  } else {
    $enctype = "application/x-www-form-urlencoded";
    $method = "get";
  }
  warn "me[$me]enctype[$enctype]method[$method]";
  push @m, qq{<form
 action="$me"
 enctype="$enctype"
 method="$method">};
  @m;
}

1;