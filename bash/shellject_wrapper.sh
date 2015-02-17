shellject ()
{
  local executable output shellject_exit eval_exit
  executable=$( type -P shellject );
  output=$( $executable $@ );
  shellject_exit=$?;
  if [[ $shellject_exit == 0 && "$1" == "load" && ! $@ =~ "--help" ]]; then
    eval "$output";
    eval_exit=$?
    if [[ $eval_exit != 0 ]]; then
      echo "Loading shelljection $2 FAILED";
      return $eval_exit
    fi;
  else
    if [[ $shellject_exit == 0 ]]; then
      echo "$output";
    else
      return $shellject_exit;
    fi;
  fi
}
