requires 'FindBin';
requires 'JSON';
requires 'Moo';
requires 'Path::Tiny';
requires 'Ref::Util';
requires 'Try::Tiny';
requires 'Type::Tiny';

on test => sub {
    requires 'Test2::V0';
};
